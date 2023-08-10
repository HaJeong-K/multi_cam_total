import scrapy


class WorldometerSpider(scrapy.Spider):
    name = "worldometer"
    allowed_domains = ["www.worldometers.info"]
    start_urls = ["https://www.worldometers.info/world-population/population-by-country"]

    def parse(self, response):

        # step 1
        '''
        title = response.xpath('//h1/text()').get()

        # 'a' 요소 추출 for each country
        countries = response.xpath('//tbody/tr/td/a/text()').getall()

        yield {
            'title' : title,
            'countries' : countries
        }
        '''
        # step 2
        '''
        countries = response.xpath('//tbody/tr/td/a')

        for country in countries:
            country_name = country.xpath('.//text()').get()
            link = country.xpath('.//@href').get()
        
            # link의 앞부분을 붙여 바로 사용할 수 있도록 함
            absolute_link = f"https://www.worldometers.info{link}"
            
            yield {
                'country_name' : country_name,
                'link' : absolute_link
            }
        '''
        countries = response.xpath('//tbody/tr/td/a')

        for country in countries:
            country_name = country.xpath(".//text()").get()
            link = country.xpath(".//@href").get()

            # 다른 페이지로 넘어가려면 URL
            # 절대 경로    '/world-population/saint-helena-population/'}
            # absolute_url = f'https://www.worldometers.info/{link}'

            # absolute_url = response.urljoin(link)
            # yield scrapy.Request(url=absolute_url) # request with absolute url
            # 상대경로
            yield response.follow(url=link, callback=self.parse_country, meta = {'country' : country_name})

            # 상대경로(* scrapy에서 상대경로!! )
    def parse_country(self, response):
        country = response.request.meta['country']
        # rows = response.xpath('(//table[@class="table table-striped table-bordered table-hover table-condensed table-list"])[1]/tbody/tr')

        rows = response.xpath('(//table[contains(@class, "table")])[1]/tbody/tr')
        for row in rows:
            year = row.xpath(".//td[1]/text()").get()
            population = row.xpath(".//td[2]/strong/text()").get()

            yield {
                'country' : country, 
                'year' : year, 
                'population': population
            }