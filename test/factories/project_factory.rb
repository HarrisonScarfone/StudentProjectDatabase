FactoryBot.define do
  factory :project do
    title { 'Test Project' }
    department { 'electrical' }
    abstract { 'This is a test abstract' * 10 }
    video_link { 'https://www.youtube.com/embed/a46Ako2Y970' }
    year {2021}
  end
end