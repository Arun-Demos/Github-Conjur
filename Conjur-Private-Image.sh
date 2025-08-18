# Clone your fork (recommended) or the source repo
git clone https://github.com/your-org/conjur-action.git
cd conjur-action

# (Optional) pin the base image in Dockerfile to a version you’ve mirrored internally
# FROM alpine:3.20  -> FROM <your-mirror>/alpine:3.20

# Build for your runner’s arch (usually linux/amd64)
docker build -t private-repo/conjur-action:1.0.0 .

# Push
docker push private-repo/conjur-action:1.0.0

# Clean up
cd ..
rmdir conjur-action
