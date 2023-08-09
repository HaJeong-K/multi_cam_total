import requests
from bs4 import BeautifulSoup
import pandas as pd

def creadDF(result_list):
    result_df = pd.DataFrame({"title" : result_list})

    return result_df

def crawler(soup):
    # print(soup) # 여기까지 전달 잘됨
    
    tbody = soup.find("tbody")
    result = []
    for p in tbody.find_all("p", class_ = "title"): # find_all 반환값 형태는 리스트다! 
        result.append(p.get_text().replace('\n', ''))

    return result

def main():

    # 요청 url 변수에 담긴 url의 html 문서를 출력한다. 
    custom_header = {
        'user-agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36'
    }
    
    url = "https://music.bugs.co.kr/chart"
    req = requests.get(url, headers = custom_header)
    soup = BeautifulSoup(req.text, "html.parser")
    result = crawler(soup)
    df = creadDF(result)
    print(df)
    df.to_csv("result.csv", index=False)

if __name__ == "__main__":
    main()
