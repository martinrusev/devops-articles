build_ansible_base:
	cp ansible/Dockerfile.base Dockerfile
	docker build --force-rm=true --rm=true --no-cache --tag="martinrusev/tdd-ansible" .    
	rm Dockerfile
	docker rmi $$(docker images -q --filter dangling=true)


build_salt_base:
	cp saltstack/Dockerfile.base Dockerfile
	docker build --force-rm=true --rm=true --no-cache --tag="martinrusev/tdd-saltstack" .    
	rm Dockerfile
	docker rmi $$(docker images -q --filter dangling=true)

# =====================
# Test
# =====================
test_ansible: 
	cp ansible/Dockerfile Dockerfile
	docker build --force-rm=true --rm=true --no-cache .  
	rm Dockerfile
	docker rmi $$(docker images -q --filter dangling=true)


test_salt: 
	cp saltstack/Dockerfile Dockerfile
	cp saltstack/states/vim.sls vim.sls
	cp saltstack/minion.yml minion.yml
	docker build --force-rm=true --rm=true --no-cache .  
	rm Dockerfile
	rm vim.sls
	docker rmi $$(docker images -q --filter dangling=true)


clean:
	docker rmi $$(docker images -q --filter dangling=true)