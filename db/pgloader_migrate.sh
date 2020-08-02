docker-compose exec postgres pgloader \
mysql://root:tcell@mysql:3306/shared_data \
postgresql://postgres:root@localhost:5432/postgres