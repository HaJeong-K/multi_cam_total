import requests
from bs4 import BeautifulSoup
import pandas as pd

com_codes = ["030200", "005930", "005490", "035720"]
com_names = ["KT", "삼성전자", "POSCO홀딩스", "카카오"]

def get_stock_price(code):
    url = f"https://finance.naver.com/item/main.naver?code={code}"
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    price = soup.select_one(".no_today .blind").text.strip()
    return price

data = []

for code, name in zip(com_codes, com_names):
    price = get_stock_price(code)
    data.append((code, name, price))

df = pd.DataFrame(data, columns=['종목코드', '상장회사', '주가'])
print(df)
