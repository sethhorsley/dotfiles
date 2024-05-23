#!/bin/bash

echo "==> 📜 Before install - Setup 3 - add sensitive data"

# op account add --address my.1password.com --email $op_email
op account add --address my.1password.com
eval $(op signin --account my)

# ssh_key_location=$(decrypt_string_with_pass "U2FsdGVkX1/ErNE4sAo/e5snN1SSpxczOsT7+OHGFC09VFII9gr8kYS4pe5+muEo GOAEFyVIoiOqa3WUWd5yls42csT8qqd3wLJdwI5dX/bKOFBwAGleou1+e0G038iQ aBn3zC8rI+8JemD20tNiUw==")
# op account add --address my.1password.com --email $email
# eval $(op signin --account my)
#
# ssh_key_location=$(decrypt_string_with_pass "U2FsdGVkX1/ErNE4sAo/e5snN1SSpxczOsT7+OHGFC09VFII9gr8kYS4pe5+muEo GOAEFyVIoiOqa3WUWd5yls42csT8qqd3wLJdwI5dX/bKOFBwAGleou1+e0G038iQ aBn3zC8rI+8JemD20tNiUw==")
