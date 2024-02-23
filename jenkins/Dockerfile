#
#  Author: Hari Sekhon
#  Date: 2022-01-20 15:00:07 +0000 (Thu, 20 Jan 2022)
#
#  vim:ts=4:sts=4:sw=4:et
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# Use JCasC to do this instead now
#
# See:
#
#   https://github.com/HariSekhon/Kubernetes-configs/blob/master/jenkins/base/values.yaml
#

# and execute everything in dynamically spawned Kubernetes pod agents using docker images containing everything you need
#
#   - see https://github.com/HariSekhon/Kubernetes-configs/blob/master/jenkins/base/agent-pod.yaml
#   - and adjacent docker-image-jenkins for deriving your own custom docker image from the default jenkins agent on debian

# nosemgrep: dockerfile.audit.dockerfile-source-not-pinned.dockerfile-source-not-pinned
FROM jenkins/jenkins:lts

RUN /bin/jenkins-plugin-cli --plugins workflow-aggregator:2.6
