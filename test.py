#! /usr/bin/python
# -*- coding: utf-8 -*-
import time
import datetime
from selenium import webdriver

path = "C:/Users/zzlhy/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Python 3.7/chromedriver.exe"
driver = webdriver.Chrome(path)


def getGoodsInfo_4(fDirectory, numOfGoods):
    count = 0
    page = 1
    check = 0

    for i in range(1, numOfGoods):
        if count < 100:
            count = count + 1
            check += 1
            a = driver.find_element_by_xpath("/html/body/div[7]/div[2]/div[1]/div[6]/div[2]/ul/li[" + str(
                count) + "]/div[1]/a")
            link = a.get_attribute("href")
            img = driver.find_element_by_xpath("// *[ @ id = \"contents\"] / div[6] / div[2] / ul/li[" + str(
                count) + "]/div[1]/a/img")
            image = img.get_attribute("ec-data-src")
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

            print(title)
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

    print(check)

def getGoodsLinks(shopName):
    fDirectory = "C:\\Users\\zzlhy\\Desktop\\리리앤코"

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

    print("----- " + shopName + " Done! -----")

getGoodsLinks("리리앤코")

driver.quit()
