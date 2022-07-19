:: Build the Docker image for pears_monthly_data_cleaning.py
docker build -t il_fcs/pears_monthly_data_cleaning:latest .
:: Create and start the Docker container 
docker run --name pears_monthly_data_cleaning il_fcs/pears_monthly_data_cleaning:latest
:: Copy /example_outputs from the container to the build context
docker cp pears_monthly_data_cleaning:/pears_monthly_data_cleaning/example_outputs/ ./
:: Remove the container
docker rm pears_monthly_data_cleaning
pause
