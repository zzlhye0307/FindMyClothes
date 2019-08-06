#! /usr/bin/python
# -*- coding: utf-8 -*-
import time
import datetime
from selenium import webdriver

path = "/Users/cs402a/Desktop/chromedriver"
driver = webdriver.Chrome(path)


def getGoodsInfo_1(fDirectory, numOfGoods):
    count = 0
    page = 1

    for i in range(1, numOfGoods):
        try:
            if count < 64:
                count = count + 1
                a = driver.find_element_by_xpath(
                    "/ html / body / div[4] / div[2] / div[2] / div[3] / div[4] / ul / li[" + str(
                        count) + "]/div/div[1]/div/a")
                link = a.get_attribute("href")
                img = driver.find_element_by_xpath(
                    "/ html / body / div[4] / div[2] / div[2] / div[3] / div[4] / ul / li[" + str(
                        count) + "]/div/div[1]/div/a/img")
                image = img.get_attribute("src")
                span1 = driver.find_element_by_xpath(
                    "/ html / body / div[4] / div[2] / div[2] / div[3] / div[4] / ul / li[" + str(
                        count) + "]/div/div[2]/strong/a/span[2]")
                title = span1.text
                span2 = driver.find_element_by_xpath(
                    "/ html / body / div[4] / div[2] / div[2] / div[3] / div[4] / ul / li[" + str(
                        count) + "]/div/div[2]/ul/li[1]/span[1]")
                price = span2.text
                try:
                    try:
                        span3 = driver.find_element_by_xpath(
                            "/ html / body / div[4] / div[2] / div[2] / div[3] / div[4] / ul / li[" + str(
                                count) + "]/div/div[2]/ul/li[3]/span")
                    except:
                        span3 = driver.find_element_by_xpath(
                            "/ html / body / div[4] / div[2] / div[2] / div[3] / div[4] / ul / li[" + str(
                                count) + "]/div/div[2]/ul/li[2]/span")
                    description = span3.text
                except:
                    description = ""

                w_desc = link, image, title, price, description
                print(title)

                with open(fDirectory, "a", encoding="utf-8") as f:
                    f.write(str(w_desc))
                    f.write("\n")
            else:
                count = 0
                page = page + 1
                next_button = driver.find_element_by_xpath(
                    "/html/body/div[4]/div[2]/div[2]/div[4]/ol/li[" + str(page) + "]/a")
                next_page_url = next_button.get_attribute("href")
                driver.get(next_page_url)
        except:
            print("error1")


def getGoodsInfo_2(fDirectory, numOfGoods):
    count = 0
    page = 1

    for i in range(1, numOfGoods):
        try:
            if count < 60:
                count = count + 1
                a = driver.find_element_by_xpath(
                    "/html/body/div[2]/div[2]/div[1]/div[2]/div[2]/div[2]/div[2]/ul/li[" + str(
                        count) + "]/div/div[1]/a")
                link = a.get_attribute("href")
                img = driver.find_element_by_xpath(
                    "/html/body/div[2]/div[2]/div[1]/div[2]/div[2]/div[2]/div[2]/ul/li[" + str(
                        count) + "]/div/div[1]/a/img")
                image = img.get_attribute("src")
                span1 = driver.find_element_by_xpath(
                    "/html/body/div[2]/div[2]/div[1]/div[2]/div[2]/div[2]/div[2]/ul/li[" + str(
                        count) + "]/div/p/a/span")
                title = span1.text
                span2 = driver.find_element_by_xpath(
                    "/html/body/div[2]/div[2]/div[1]/div[2]/div[2]/div[2]/div[2]/ul/li[" + str(
                        count) + "]/div/ul/li[1]/span[1]")
                price = span2.text
                try:
                    span3 = driver.find_element_by_xpath(
                        "/html/body/div[2]/div[2]/div[1]/div[2]/div[2]/div[2]/div[2]/ul/li[" + str(
                            count) + "]/div/ul/li[3]/span")
                except:
                    span3 = driver.find_element_by_xpath(
                        "/html/body/div[2]/div[2]/div[1]/div[2]/div[2]/div[2]/div[2]/ul/li[" + str(
                            count) + "]/div/ul/li[4]/span")

                description = span3.text

                w_desc = link, image, title, price, description
                print(title)
                with open(fDirectory, "a", encoding="utf-8") as f:
                    f.write(str(w_desc))
                    f.write("\n")
            else:
                count = 0
                page = page + 1
                next_button = driver.find_element_by_xpath(
                    "/html/body/div[2]/div[2]/div[1]/div[2]/div[2]/div[3]/a[3]")
                next_page_url = next_button.get_attribute("href")
                driver.get(next_page_url)
        except:
            print("error2")

def getGoodsInfo_3(fDirectory, numOfGoods):
    count = 0
    page = 1

    for i in range(1, numOfGoods):
        if count < 40:
            count = count + 1
            a = driver.find_element_by_xpath(
                "/html/body/div[2]/div[2]/div[1]/div[2]/div[4]/div[2]/ul/li[" + str(
                    count) + "]/div[1]/a")
            link = a.get_attribute("href")
            img = driver.find_element_by_xpath(
                "/html/body/div[2]/div[2]/div[1]/div[2]/div[4]/div[2]/ul/li[" + str(
                    count) + "]/div[1]/a/img")
            image = img.get_attribute("src")
            try:
                span1 = driver.find_element_by_xpath(
                    "/html/body/div[2]/div[2]/div[1]/div[2]/div[4]/div[2]/ul/li[" + str(
                        count) + "]/div[2]/strong/a/span[2]")
                title = span1.text
            except:
                span1 = driver.find_element_by_xpath(
                    "/html/body/div[2]/div[2]/div[1]/div[2]/div[4]/div[2]/ul/li[" + str(
                        count) + "]/div[2]/strong/a")
                title = span1.text
            span2 = driver.find_element_by_xpath(
                "/html/body/div[2]/div[2]/div[1]/div[2]/div[4]/div[2]/ul/li[" + str(
                    count) + "]/div[2]/ul/li[1]/span[1]")
            price = span2.text
            try:
                span3 = driver.find_element_by_xpath(
                    "/html/body/div[2]/div[2]/div[1]/div[2]/div[4]/div[2]/ul/li[" + str(
                        count) + "]/div[2]/ul/li[2]/span")
                description = span3.text
            except:
                try:
                    span3 = driver.find_element_by_xpath(
                        "/html/body/div[2]/div[2]/div[1]/div[2]/div[4]/div[2]/ul/li[" + str(
                            count) + "]/div[2]/ul/li[3]/span")
                    description = span3.text
                except:
                    description = ""

            w_desc = link, image, title, price, description
            with open(fDirectory, "a", encoding="utf-8") as f:
                f.write(str(w_desc))
                f.write("\n")
        else:
            count = 0
            page = page + 1
            next_button = driver.find_element_by_xpath(
                "/html/body/div[2]/div[2]/div[1]/div[2]/div[5]/a[3]")
            next_page_url = next_button.get_attribute("href")
            driver.get(next_page_url)
            
def getGoodsInfo_4(fDirectory, numOfGoods):
    count = 0
    page = 1
    
    for i in range(1, numOfGoods):
        if count < 100:
            count = count + 1
            a = driver.find_element_by_xpath("/html/body/div[7]/div[2]/div[1]/div[6]/div[2]/ul/li[" + str(
                    count) + "]/div[1]/a")
            link = a.get_attribute("href")
            img = driver.find_element_by_xpath("/html/body/div[7]/div[2]/div[1]/div[6]/div[2]/ul/li[" + str(
                    count) + "]/div[1]/a/img")
            image = img.get_attribute("src")
            span1 = driver.find_element_by_xpath("/html/body/div[7]/div[2]/div[1]/div[6]/div[2]/ul/li[" + str(
                    count) + "]/div[2]/strong/a/span[2]")
            title = span1.text
            span2 = driver.find_element_by_xpath("/html/body/div[7]/div[2]/div[1]/div[6]/div[2]/ul/li[" + str(
                    count) + "]/div[2]/ul/li[1]/span")
            price = span2.text
            try:
                span3 = driver.find_element_by_xpath("/html/body/div[7]/div[2]/div[1]/div[6]/div[2]/ul/li[" + str(
                        count) + "]/div[2]/ul/li[5]/span")
                description = span3.text
            except:
                try:
                    span3 = driver.find_element_by_xpath("/html/body/div[7]/div[2]/div[1]/div[6]/div[2]/ul/li[" + str(
                            count) + "]/div[2]/ul/li[4]/span")
                    description = span3.text
                except:
                    span3 = driver.find_element_by_xpath("/html/body/div[7]/div[2]/div[1]/div[6]/div[2]/ul/li[" + str(
                            count) + "]/div[2]/ul/li[3]/span")
                    description = span3.text

            w_desc = link, image, title, price, description
            with open(fDirectory, "a", encoding="utf-8") as f:
                f.write(str(w_desc))
                f.write("\n")
        else:
            count = 0
            page = page + 1
            next_button = driver.find_element_by_xpath(
                "/html/body/div[7]/div[2]/div[1]/div[7]/a[2]")
            next_page_url = next_button.get_attribute("href")
            driver.get(next_page_url)
            
def getGoodsInfo_5(fDirectory, numOfGoods):
    count = 0
    page = 1
    
    for i in range(1, numOfGoods):
        try:
            if count < 100:
                count = count + 1
                a = driver.find_element_by_xpath(
                    "/html/body/div[2]/div[3]/div[1]/div[5]/div[2]/ul/li[" + str(
                        count) + "]/div[1]/a")
                link = a.get_attribute("href")
                img = driver.find_element_by_xpath(
                    "/html/body/div[2]/div[3]/div[1]/div[5]/div[2]/ul/li[" + str(
                        count) + "]/div[1]/a/img")
                image = img.get_attribute("src")
                span1 = driver.find_element_by_xpath(
                    "/html/body/div[2]/div[3]/div[1]/div[5]/div[2]/ul/li[" + str(
                        count) + "]/div[2]/p/a/span[2]")
                title = span1.text
                span2 = driver.find_element_by_xpath(
                    "/html/body/div[2]/div[3]/div[1]/div[5]/div[2]/ul/li[" + str(
                        count) + "]/div[2]/ul/li[2]")
                price = span2.text
                span3 = driver.find_element_by_xpath(
                    "/html/body/div[2]/div[3]/div[1]/div[5]/div[2]/ul/li[" + str(
                        count) + "]/div[2]/ul/li[3]")
                description = span3.text

                w_desc = link, image, title, price, description

                with open(fDirectory, "a", encoding="utf-8") as f:
                    f.write(str(w_desc))
                    f.write("\n")
            else:
                count = 0
                page = page + 1
                next_button = driver.find_element_by_xpath(
                    "/html/body/div[2]/div[3]/div[1]/div[6]/a[3]")
                next_page_url = next_button.get_attribute("href")
                driver.get(next_page_url)
        except:
            time.sleep(0.001)
            
def getGoodsLinks(shopName):
    fName = "상품정보"
    fDirectory = "/Users/cs402a/Desktop/PythonFile/" + fName
    
    if shopName == "육육걸즈":
        # category_list = 아우터, 상의, 셔츠/블라우스, 팬츠/데님, 스커트, 원피스
        category_list = ["https://66girls.co.kr/product/list.html?cate_no=81",
                        "https://66girls.co.kr/product/list.html?cate_no=70",
                        "https://66girls.co.kr/product/list.html?cate_no=69",
                        "https://66girls.co.kr/product/list.html?cate_no=71",
                        "https://66girls.co.kr/product/list.html?cate_no=86",
                        "https://66girls.co.kr/product/list.html?cate_no=233"]
        
        for url in category_list:
            driver.get(url)
            strong = driver.find_element_by_xpath("/html/body/div[4]/div[2]/div[2]/div[3]/div[1]/div/p/strong")
            numOfGoods = int(strong.text)
            getGoodsInfo_1(fDirectory, numOfGoods)
    
    if shopName == "핫핑":
        # category_list = 드레스, 아우터, 탑, 니트, 블라우스, 하의, 스커트
        category_list = ["http://hotping.co.kr/product/list.html?cate_no=26",
                        "http://hotping.co.kr/product/list.html?cate_no=27",
                        "http://hotping.co.kr/product/list.html?cate_no=29",
                        "http://hotping.co.kr/product/list.html?cate_no=66",
                        "http://hotping.co.kr/product/list.html?cate_no=28",
                         "http://hotping.co.kr/product/list.html?cate_no=31",
                         "http://hotping.co.kr/product/list.html?cate_no=535"]
        
        for url in category_list:
            driver.get(url)
            strong = driver.find_element_by_xpath("/html/body/div[2]/div[2]/div[1]/div[2]/div[2]/div[2]/div[1]/div/strong")
            numOfGoods = int(strong.text)
            getGoodsInfo_2(fDirectory, numOfGoods)
            
    if shopName == "슬로우앤드":
        # category_list = 아우터, 탑, 드레스, 스커트, 하의
        category_list = ["https://www.slowand.com/category/outer/24/",
                        "https://www.slowand.com/category/top/25/",
                        "https://www.slowand.com/category/dress/27/",
                        "https://www.slowand.com/category/skirt/70/",
                        "https://www.slowand.com/category/bottom/26/"]
        
        for url in category_list:
            driver.get(url)
            strong = driver.find_element_by_xpath("/html/body/div[2]/div[2]/div[1]/div[2]/div[4]/div[1]/div/p/strong")
            numOfGoods = int(strong.text)
            getGoodsInfo_3(fDirectory, numOfGoods)
        
    if shopName == "리리앤코":
        # category_list = 원피스, 블라우스, 아우터, 니트, 상의/티, 하의
        category_list = ["https://ririnco.com/product/list.html?cate_no=53",
                        "https://ririnco.com/product/list.html?cate_no=269",
                        "https://ririnco.com/product/list.html?cate_no=56",
                        "https://ririnco.com/product/list.html?cate_no=138",
                         "https://ririnco.com/product/list.html?cate_no=55",
                        "https://ririnco.com/product/list.html?cate_no=57"]
        
        for url in category_list:
            driver.get(url)
            strong = driver.find_element_by_xpath("/html/body/div[7]/div[2]/div[1]/div[6]/div[1]/div/p/strong")
            numOfGoods = int(strong.text)
            getGoodsInfo_4(fDirectory, numOfGoods)
            
    if shopName == "로렌하이":
        # category_list = 아우터, 상의, 티셔츠, 블라우스/셔츠, 원피스, 바지, 스커트
        category_list = ["http://laurenhi.com/product/list.html?cate_no=12",
                         "http://laurenhi.com/product/list.html?cate_no=519",
                        "http://laurenhi.com/product/list.html?cate_no=24",
                        "http://laurenhi.com/product/list.html?cate_no=94",
                        "http://laurenhi.com/product/list.html?cate_no=25",
                         "http://laurenhi.com/product/list.html?cate_no=7",
                         "http://laurenhi.com/product/list.html?cate_no=43"]
        
        for url in category_list:
            driver.get(url)
            strong = driver.find_element_by_xpath("/html/body/div[2]/div[3]/div[1]/div[5]/div[1]/div/p/strong")
            numOfGoods = int(strong.text)
            getGoodsInfo_5(fDirectory, numOfGoods)
            
    print("----- " + shopName + " Done! -----")


getGoodsLinks("육육걸즈")
getGoodsLinks("핫핑")
getGoodsLinks("슬로우앤드")
getGoodsLinks("리리앤코")
getGoodsLinks("로렌하이")

driver.quit()
