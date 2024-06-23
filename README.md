PROJECT : MEMBUAT TABLE DATABASE DI POSTGRESQL DENGAN [ DBT ] 

<<>> ---------------------------------FINISH--------------------------------- <<>>

A. create a virtual env of python first :
``` 
1. python -m venv "C:\Users\gustii.ap\ftde_dbt\venv_dskola" (membuat virtual env)
2. cd "C:\Users\gustii.ap\ftde_dbt\venv_dskola" (memeriksa posisi file)
3. .\Scripts\activate(mengaktifkan env)
```

B. git pull (pull data dari git)
```
1. menuju lokasi directory
>> cd "D:\Training Data Engineer\Project\Project_2"
2. cler semua file pada folder tujuan (proses git pull folder harus cleasr)
>> Remove-Item -Recurse -Force "D:\Training Data Engineer\Project\Project_2\*" --> 

3. lakukan git clone (untuk cloning data)
>> git clone https://gitlab.com/farhansmg/learn_dbt.git "D:\Training Data Engineer\Project\project_2_team1" 
```

C. sebelum menjalankan program dbt keluar dari dir env menuju dir folder project dbt
```
1. contoh current directory 
>> (venv_dskola) PS C:\Users\gustii.ap\ftde_dbt\venv_dskola>

>> cd "D:\Training Data Engineer\Project\project_2_team1"
>> ls : (melihat list directory)

2. setelah mengetahui direktori yang akan dikunjungi
>> cd .\dbt_project2_t1\ 
``` 

- [optional] jika menggunakan docker
```
build the postgres image
1. docker build -t {postgres_image_name} -f Dockerfile.postgres .
2. masuk ke >>  docker build -t dbt_project2 -f Dockerfile.postgres .
```

- [optional] run postgres container
if you want to check the result on local (uncomment first the EXPOSE command on dockerfile postgres)
```
docker run -d -p 5432:5432 --name {postgres_container_name} {postgres_image_name}
-->> docker run -d -p 5432:5432 --name dbt_postgres dbt_project2

>> jika docker sudah terbentuk maka :
1. stop docker all container
>> docker stop $(docker ps -a -q) 
2. contoh stop 1 container 
>> docker stop dbt_postgres
3. contoh hapus semua container
>> docker rm $(docker ps -a -q)
4. contoh hapus 1 container 
>> docker rm dbt_postgres
5. docker ps (periksa container yang sedang berjalan)
6. docker logs dbt_postgres -f (untuk melihat history docker logs)
7. docker exec -it dbt_postgres psql -U dbtAdmin -d db_dskola -c "\dt" -->> memastikan koneksi postgre
```

D. periksa konfigurasi dbt dengan cara debug your dbt connection
```
1. untuk membuat profiles baru
>> notepad "D:\Training Data Engineer\Project\project_2\profiles.yml"

2. untuk memeriksa lokasi config profils
>> dbt debug --config-dir

3. (optional) untuk menuju profiles sesuai directory
>> dbt debug --profiles-dir ./ --project-dir dbt_project2_t1

4. untuk melakukan default directory profiles.yml
>> $env:DBT_PROFILES_DIR = "D:\Training Data Engineer\Project\Project_2"

5. masuk ke dir dbt_project
>> cd .\dbt_project2_t1\

6. test connection
>> dbt debug
```

E. untuk packages clear packages 
```
>> dbt clean 
```

F. untuk instal packages
```
1. buat konfigurasi packages.yml
2. setelah packages terbentuk
3. running deps untuk membentuk packages
>> dbt deps 
```

F. run dbt model
```
1. Jika posisi dir sudah sesuai maka langsung running dbt
>> dbt run

2. (optional) apabila dir masih belum sesuai di dir project dbt maka 
>> dbt run --profiles-dir ./ --project-dir dbt_project2_t1 
```

5. untuk mendokumentasikan skema, tabel, kolom, dan hubungan antar tabel dalam database yang dikelola oleh DBT
```
dbt docs generate 
```

6. untuk running ke server dbt http://localhost:8080/#!/overview/dbt_project2_t1
```
1. jika folder yang akan di running sudah sesuai dengan folder project maka
>> dbt docs serve
2. jika folder yang akan di running belum sesuai dengan folder project maka
>> dbt docs serve --profiles-dir ./ --project-dir dbt_project2_t1
```

<<>> ---------------------------------FINISH--------------------------------- <<>>
