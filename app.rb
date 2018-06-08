require 'sinatra'
require "sinatra/reloader"

require "rest-client"
require "json"

require 'httparty'
require 'nokogiri'
require 'uri'
require 'date'
require 'csv'

#아래 메소드들을 실행하기 전에 항상 실행하는 부분
    before do 
        p "*************************"#서버에 로그로 찍힘
        p params
        p request.path_info #사용자가 요청보낸 경로
        p request.fullpath #파라미터까지 포함한 경로
        p"**************************"
        end
    

get '/' do
  'Hello world!~~welcome'
end

get '/htmlfile' do
    send_file 'views/htmlfile.html'
    
end

get '/htmltag' do
    '<h1>send html tag</h1>
    <ul><li>cake</li>
    <li>cheese</li></ul>
    '
    
end

get '/welcome/:name' do
 
 "#{params[:name]}님 안녕하세요"

end

get '/cube/:num' do
 a=params[:num].to_i**3
 "<h1>result: #{a}</h1>"
 #=#{params[:num].to_i**3}
end


get '/erbfile' do
   
   @name = "sffds"
   erb :erbfile
   
end


get '/lunch-array' do
    #메뉴들을 배열에 저장한다.
    #하나를 추천한다
    #erb 파일에 담아서 랜더링한다.
    lunch=["cake","cheese","susi","malatang"]
    @lunch=lunch.sample
    # @lunch=lunch.sample(1)이면 "susi" 식으로 그자체가 출력됨
    erb:luncharr
end

get '/lunch-hash' do
    #메뉴들이 저장된 hash배열을 만든다
    #메뉴이름이 키고 사진url이 밸류
    #랜덤으로 하나를 출력한다.
    #이름과 url을 넘겨서 erb를 랜더링한다.
    menu=["cake","icecream","waffle"]
    
    #앞에가 string 일때는 =>으로 해쉬값 설정해야함
    menu_img= {"cake"=>"http://www.twosome.co.kr//Twosome_file/PRODUCT/1488_big_img",
    "icecream"=>"https://t1.daumcdn.net/cfile/tistory/25718A375769609E14",
    "waffle"=>"https://assets.simplyrecipes.com/wp-content/uploads/2016/09/Buttermilk-Waffles-vertical-b-1600.jpg" }
    @menu_result=menu.sample
    @menu_img=menu_img[@menu_result]
    erb :lunchhash
end

get '/randomgame' do
    
    random=["학생","농부","백수","아이돌","선생님","회사원","부자","거지","헬스트레이너","개발자","요리사"]
    color={"학생"=>"red","농부"=>"#00b33c","백수"=>"#8c8c8c","아이돌"=>"#d580ff","선생님"=>"#00e6b8",
    "회사원"=>"black","부자"=>"#d580ff","거지"=>"#8c8c8c","헬스트레이너"=>"#00e6b8","개발자"=>"#8c8c8c","요리사"=>"#00b33c"}
    @result=random.sample
    @color=color[@result]
    erb :random
    end
    
    get '/lotto-sample' do
    #랜덤하게 로또번호 출력
  # @lotto =(1..45).to_a.sample(6).sort
   @lotto=[6,11,15,17,23,39]
    #render to erb
    url="http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=809"
    @lotto_info = RestClient.get(url)#json data 
    @lotto_hash=JSON.parse(@lotto_info)
    @lotto_num=[] 
 
   @lotto_hash.each do |k,v| #여기서 k랑 v는 hash안에 key,value값을 의미
   @lotto_num << v if k.include?("drwtNo")
     end 
     
     
     #몇 개가 맞았는지 확인
     #첫번쨰 방법
     @result=(@lotto&@lotto_num).length
     
     
     #두번째 방법
      @result2=0
     @lotto_num.each do |v|
         @result2 +=1 if @lotto.include?(v)
     end
    
    #보너스 넘버
     @bonus_num=@lotto_hash["bnusNo"]


     #몇 등인지 if
     
    if @result==3
         @win="5등 입니다."
    elsif @result==4
         @win="4등 입니다."
    elsif  @result==5&&@lotto.include?(@bonus_num)
         @win="2등 입니다."
    elsif @result==5
         @win="3등 입니다."
    elsif @result==6
         @win="1등 입니다."
    else @win="꽝"
    end
    
    #몇 등인지 case
    @win2=
    case[ @result,@lotto.include?(@bonus_num)]
    when [6,false] then "1등" # 이 값이 리턴되므로 case문르 변수로 받으면 이값을 받는 것과 같음
    when [5,true] then "2등"
    when [5,false] then "3등"
    when [4,false] then "4등"
    when [3,false] then "5등"
    else "꽝"
    end
    erb :lotto
    end
    
    
    

    get '/form' do
        erb :form
    end
    
    get '/search' do
        @keyword=params[:keyword]
        url='https://search.naver.com/search.naver?&query='
        redirect to (url+@keyword)
       #erb :search 
    end
    
    get '/opgg' do
        erb :opgg
        
    end
    
    get '/opggresult' do
       url="http://www.op.gg/summoner/userName="
       @userName=params[:userName]
       #encoding
       @encodeName=URI.encode(@userName)
       
       @res=HTTParty.get(url+@encodeName)
       #이떄는 redirect랑 다르게 페이지의 html을 가져와서 보여주는 방식
       
       @doc=Nokogiri::HTML(@res.body)
       @win=@doc.css("#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div.SummonerRatingMedium > div.TierRankInfo > div.TierInfo > span.WinLose > span.wins")
       @lose=@doc.css("#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div.SummonerRatingMedium > div.TierRankInfo > div.TierInfo > span.WinLose > span.losses")
       @rank=@doc.css("#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div.SummonerRatingMedium > div.TierRankInfo > div.TierInfo > span.WinLose > span.winratio")
       @level=@doc.css("#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div.SummonerRatingMedium > div.TierRankInfo > div.TierRank")

       
       erb:opggresult
    end