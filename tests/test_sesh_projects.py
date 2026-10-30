"""Run with python3 tests/test_sesh_projects.py; uses an isolated zoxide database."""
import os
from pathlib import Path
import subprocess
import tempfile

script = Path(__file__).resolve().parents[1] / "home/dot_local/bin/executable_sesh-projects"
with tempfile.TemporaryDirectory() as tmp:
    root = Path(tmp)
    env = {**os.environ, "HOME": tmp, "_ZO_DATA_DIR": tmp}
    history = root / "previously visited"
    history.mkdir()
    subprocess.run(["zoxide", "add", str(history)], env=env, check=True)

    def listing():
        return subprocess.check_output(["sh", str(script)], env=env, text=True).splitlines()

    assert listing() == [str(history)]  # No files directory yet.
    project = root / "files/owner/project with spaces"
    (project / "nested").mkdir(parents=True)
    (project.parent / "ordinary-file").touch()
    subprocess.run(["zoxide", "add", str(project)], env=env, check=True)
    before = listing()
    assert set(before) == {str(history), str(project)} and len(before) == 2

    new_project = root / "files/new-owner/new-project"
    new_project.mkdir(parents=True)
    after = listing()
    assert after == before + [str(new_project)], after
print("PASS: new projects appear immediately; history, spaces, depth, and deduplication work")
