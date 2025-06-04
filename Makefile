.PHONY: build bash

VERSION := 20250604
DOCKERIMAGE := mcp-calculator-server
FULLIMAGENAME := nataliapc/$(DOCKERIMAGE)

build:
	docker build -t $(DOCKERIMAGE) . ;
	docker tag $(DOCKERIMAGE) $(FULLIMAGENAME):$(VERSION) ;
	docker tag $(DOCKERIMAGE) $(FULLIMAGENAME):latest ;
	docker image rm $(DOCKERIMAGE) ;

bash:
	docker run -it --rm -p 8080:8080 $(DOCKERIMAGE) bash ;

push:
	docker push $(FULLIMAGENAME):$(VERSION) ;
	docker push $(FULLIMAGENAME):latest ;