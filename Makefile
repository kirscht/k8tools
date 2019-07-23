DOCKER_IMAGE = k8s-tools

KUBERNETES_TOOLS := docker run \
		-ti \
		--rm \
		--network=host \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v $(PWD):/k8s \
		-v $(HOME)/.aws:/root/.aws \
        -v $(HOME)/.ssh:/root/.ssh \
        -v $(HOME)/.kube:/root/.kube \
        -e ENV=${ENV} \
		${DOCKER_IMAGE}

build:
	docker build -t $(DOCKER_IMAGE) .

test: build
	${KUBERNETES_TOOLS} ls
	${KUBERNETES_TOOLS} env
	${KUBERNETES_TOOLS} ifconfig -a
	${KUBERNETES_TOOLS} ip addr show eth0
	${KUBERNETES_TOOLS} netstat -a
	${KUBERNETES_TOOLS} git version
	${KUBERNETES_TOOLS} kubectl version
	${KUBERNETES_TOOLS} kubectx
	${KUBERNETES_TOOLS} kubens
	${KUBERNETES_TOOLS} docker version ; docker ps
	${KUBERNETES_TOOLS} helm version
	${KUBERNETES_TOOLS} helm list
	${KUBERNETES_TOOLS} terraform version