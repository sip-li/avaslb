PROJECT = avaslb
DOCKER_USER = callforamerica
IMAGE = $(DOCKER_USER)/$(PROJECT)

.PHONY: build run launch logs rm

build:
	@docker build -t $(IMAGE) .

run:
	@docker run --rm --name $(PROJECT) \
		-p "80:80" \
		--cap-add NET_ADMIN \
		--cap-add SYS_NICE \
		--cap-add SYS_RESOURCE \
		--memory-swappiness=0 \
		$(IMAGE)

launch:
	@docker run -d --name $(PROJECT) \
		-p "80:80" \
		--cap-add NET_ADMIN \
		--cap-add SYS_NICE \
		--cap-add SYS_RESOURCE \
		--memory-swappiness=0 \
		$(IMAGE)

logs:
	@docker logs -f $(PROJECT)

rm:
	@docker rm -f $(PROJECT)
