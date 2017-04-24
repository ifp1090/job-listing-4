puts "这个种子档会自动建立一个admin账号，并且创建 10 个public jobs，以及10个hidden jobs"

create_account = User.create([email: 'raimonfuns@163.com', password: '123123', password_confirmation: '123123', is_admin: 'true'])
puts "Admin account created."

jobs = [
  "rails工程师",
  "api程序员",
  "iOS开发工程师",
  "前端开发工程师",
  "Html5工程师",
  "Android开发工程师",
  "测试工程师",
  "Node.js 工程狮",
  "后端工程师",
  "rails高级工程师",
  "rails工程师"
]
category = [
  "技术",
  "运营",
  "市场与销售",
  "职能",
  "金融"
]
company = [
  "logicmonitor",
  "宏利金融全球服务中心",
  "阿里巴巴集团",
  "腾讯科技深圳有限公司",
  "车轮互联",
  "京东"
]
location = [
  "北京",
  "上海",
  "广州",
  "深圳",
  "杭州"
]

create_jos = for i in 1..10 do
  Job.create!([
    title: jobs[rand(jobs.length)],
    # title: "JOB.no#{i}",
    description: "这是用种子建立的第 #{i} 个Public工作哦",
    wage_upper_bound: rand(50..99)*100 + 5000,
    wage_lower_bound: rand(10..49)*100 + 5000,
    contact_email: 'raimonfuns@163.com',
    is_hidden: "false",
    location: location[rand(location.length)],
    company_name: company[rand(company.length)],
    company_url: "http://www.xx.com",
    company_contact_email: "hr@xx.com",
    category_id: category[rand(category.length)]
  ])
end

puts "10 Public jobs created."

create_jos = for i in 1..10 do
  Job.create!([
    title: jobs[rand(jobs.length)],
    # title: "JOB.no#{i}",
    description: "这是用种子建立的第 #{i+10} 个hidden工作哦",
    wage_upper_bound: rand(50..99)*100 + 5000,
    wage_lower_bound: rand(10..49)*100 + 5000,
    contact_email: 'raimonfuns@163.com',
    is_hidden: "true",
    location: location[rand(location.length)],
    company_name: company[rand(company.length)],
    company_url: "http://www.xx.com",
    company_contact_email: "hr@xx.com",
    category_id: category[rand(category.length)]
  ])
end
puts "10 Hidden jobs created."
