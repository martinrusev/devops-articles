build_chef_base:
	cp chef/Dockerfile.base Dockerfile
	docker build --force-rm=true --rm=true --no-cache --tag="martinrusev/tdd-chef" .    
	rm Dockerfile
	docker rmi $$(docker images -q --filter dangling=true)


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


build_puppet_base:
	cp puppet/Dockerfile.base Dockerfile
	docker build --force-rm=true --rm=true --no-cache --tag="martinrusev/tdd-puppet" .    
	rm Dockerfile
	docker rmi $$(docker images -q --filter dangling=true)

# =====================
# Test
# =====================
test_chef: 
	cp chef/Dockerfile Dockerfile
	cp chef/cookbooks cookbooks
	docker build --force-rm=true --rm=true --no-cache .  
	rm Dockerfile
	rm -rf cookbooks
	docker rmi $$(docker images -q --filter dangling=true)


test_ansible: 
	cp ansible/Dockerfile Dockerfile
	docker build --force-rm=true --rm=true --no-cache .  
	rm Dockerfile
	docker rmi $$(docker images -q --filter dangling=true)


test_puppet: 
	cp puppet/Dockerfile Dockerfile
	cp puppet/apache.pp apache.pp
	docker build --force-rm=true --rm=true --no-cache .  
	rm Dockerfile
	rm apache.pp
	docker rmi $$(docker images -q --filter dangling=true)

test_salt: 
	cp saltstack/Dockerfile Dockerfile
	cp saltstack/states/vim.sls vim.sls
	cp saltstack/minion.yml minion.yml
	docker build --force-rm=true --rm=true --no-cache .  
	rm Dockerfile
	rm vim.sls
	rm minion.yml
	docker rmi $$(docker images -q --filter dangling=true)


clean:
	docker rmi $$(docker images -q --filter dangling=true)