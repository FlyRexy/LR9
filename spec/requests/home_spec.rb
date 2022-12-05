require 'rails_helper'
require 'selenium-webdriver'
include RSpec::Expectations

RSpec.describe "Homes", type: :request do
  describe "GET /input" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /result' do
    context 'when params are invalid' do
      before {  post result_path, xhr: true }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'renders result templates' do
        expect(response).to render_template(:result)
        expect(response).to render_template(:_result_table)
      end

      it 'assigns invalid model object' do
        expect(assigns(:home).valid?).to be false
      end
    end
  end
end

RSpec.describe HomeController do
  before(:each) do
    @driver = Selenium::WebDriver.for :chrome
    @base_url = "http://localhost:3000"
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end

  after(:each) do
    @driver.quit
  end

  it "should give an answer" do
    @driver.get(@base_url)
    @driver.find_element(:id, "arr").send_keys "1 4 9 5 1"
    @driver.find_element(:id, "num").send_keys "5"
    @driver.find_element(:id, "my_button").click
    verify { expect(@driver.find_element(:id, "result_area").text).to eq 'Количество отрезков равно 2' + '<br>' + 'Самый длинный из них: 1 4 9' }
  end
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
end

RSpec.describe 'Test of page with Selenium' do
  it 'check url of page' do
    driver = Selenium::WebDriver.for :chrome
    driver.get('http://localhost:3000/')
    expect(driver.current_url).to eq('http://localhost:3000/')
    driver.quit
  end
end