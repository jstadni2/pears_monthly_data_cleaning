FROM python:3.9

WORKDIR /pears_monthly_data_cleaning

COPY . .

RUN pip install -r requirements.txt

CMD [ "python", "./pears_monthly_data_cleaning.py" ]