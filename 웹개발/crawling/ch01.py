# -*- coding:UTF-8 -*-
from bs4 import BeautifulSoup

def main():

    # index.html을 불러와서 BeautifulSoup 객체 초기화
    # 웹에서 응답을 할 때, HTML, XML. JSON 그 외 여러방식이 존재

    soup = BeautifulSoup(open("html/index.html", encoding="utf-8"), "html.parser")
    print(type(soup))

    print(soup.title)

    print(soup.title.string)
    print(soup.find("p").get_text())

    # 같은 div에 소속된 경우 div 로 접근한 후 find로 더 찾는다.
    # 그리고 리스트를 활용해 텍스트 찾기를 해준다.
    target_text = soup.find('div', class_='fakecampus').find_all('p')
    print(target_text[1].get_text())

if __name__ == "__main__":
    main()