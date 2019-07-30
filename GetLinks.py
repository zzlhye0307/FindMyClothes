#! /usr/bin/python
# -*- coding: utf-8 -*-
import time
import datetime
from selenium import webdriver

path = "/Users/cs402a/Desktop/chromedriver"
driver = webdriver.Chrome(path)

def getGoodsInfo_1(fDirectory, count, numOfGoods):
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
                span3 = driver.find_element_by_xpath(
                    "/ html / body / div[4] / div[2] / div[2] / div[3] / div[4] / ul / li[" + str(
                        count) + "]/div/div[2]/ul/li[2]/span")
                description = span3.text

                w_desc = link, image, title, price, description

                with open(fDirectory, "a", encoding="utf-8") as f:
                    f.write(str(w_desc))
            else:
                count = 0
                page = page + 1
                next_button = driver.find_element_by_xpath(
                    "/html/body/div[4]/div[2]/div[2]/div[4]/ol/li[" + str(page) + "]/a")
                next_page_url = next_button.get_attribute("href")
                driver.get(next_page_url)
        except:
            time.sleep(0.001)
            
def getGoodsInfo_2(fDirectory, count, numOfGoods):
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
                print(w_desc)
                #with open(fDirectory, "a", encoding="utf-8") as f:
                    #f.write(str(w_desc))
            else:
                count = 0
                page = page + 1
                next_button = driver.find_element_by_xpath(
                    "/html/body/div[2]/div[2]/div[1]/div[2]/div[2]/div[3]/ol/li[" + str(page) +"]/a")
                next_page_url = next_button.get_attribute("href")
                driver.get(next_page_url)
        except:
            print("error!")

def getGoodsLinks(shopName):
    fName = shopName + "상품정보"
    fDirectory = "/Users/cs402a/Desktop/PythonFile/" + shopName + "/" + fName

    if shopName == "육육걸즈":
        # 아우터
        url = "https://66girls.co.kr/product/list.html?cate_no=81"
        driver.get(url)
        count = 3
        numOfGoods = 214

        getGoodsInfo_1(fDirectory, count, numOfGoods)
        
        # 상의
        url = "https://66girls.co.kr/product/list.html?cate_no=70"
        driver.get(url)
        count = 6
        numOfGoods = 424

        getGoodsInfo_1(fDirectory, count, numOfGoods)
        
        #셔츠, 블라우스
        url = "https://66girls.co.kr/product/list.html?cate_no=69"
        driver.get(url)
        count = 15
        numOfGoods = 584

        getGoodsInfo_1(fDirectory, count, numOfGoods)
        
        # 팬츠, 데님
        url = "https://66girls.co.kr/product/list.html?cate_no=71"
        driver.get(url)
        count = 0
        numOfGoods = 385

        getGoodsInfo_1(fDirectory, count, numOfGoods)
        
        #스커트
        url = "https://66girls.co.kr/product/list.html?cate_no=86"
        driver.get(url)
        count = 1
        numOfGoods = 237

        getGoodsInfo_1(fDirectory, count, numOfGoods)
        
        # 원피스
        url = "https://66girls.co.kr/product/list.html?cate_no=233"
        driver.get(url)
        count = 1
        numOfGoods = 530

        getGoodsInfo_1(fDirectory, count, numOfGoods)

    if shopName == "핫핑":
        # 드레스
        
        url = "http://hotping.co.kr/product/list.html?cate_no=26"
        driver.get(url)
        count = 0
        numOfGoods = 309

        getGoodsInfo_2(fDirectory, count, numOfGoods)
        
        '''
        # 아우터
        url = "http://hotping.co.kr/product/list.html?cate_no=27"
        driver.get(url)
        count = 0
        numOfGoods = 86

        getGoodsInfo_2(fDirectory, count, numOfGoods)
        '''
        
    driver.quit()
    print("----- " + shopName + " Done! -----")


#getGoodsLinks("육육걸즈")
getGoodsLinks("핫핑")
# getGoodsLinks("슬로우앤드")
# getGoodsLinks("리리앤코")
# getGoodsLinks("로렌하이")
