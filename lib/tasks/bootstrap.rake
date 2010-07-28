namespace :bootstrap do

  desc "Create default categories"
  task :default_category => :environment do
    Category.create( :name => 'friendly', :comment => 'friendly rated G questions', :status => 'active' )
    Category.create( :name => 'risque', :comment => 'risque rated R questions', :status => 'active' )
    Category.create( :name => 'highschool', :comment => 'questions about highschool', :status => 'inactive' )
  end

  desc "Create a default quiz"
  task :default_quiz => :environment do
    #create a quiz
    category = Category.find_by_name('friendly')
    quiz = Quiz.create( :name => 'BFF Quiz', :category_id => category.id, :status => 'active' )
    Question.create( :quiz_id => quiz.id, :content => 'What is your favorite color?', :display_order => 1 )
    Question.create( :quiz_id => quiz.id, :content => 'What is your favorite animal?', :display_order => 2 )
    Question.create( :quiz_id => quiz.id, :content => 'What is your favorite hobby?', :display_order => 3 )
    Question.create( :quiz_id => quiz.id, :content => 'What is your favorite dream vacation?', :display_order => 4 )
    Question.create( :quiz_id => quiz.id, :content => 'What is your favorite movie?', :display_order => 5 )
  end


  desc "Create a default game"
  task :default_game => :environment do
    #create a quiz
    category = Category.find_by_name('friendly')
    quiz = Quiz.find_by_name('BFF Quiz')
    #setup a game with players
    game = Game.create( :name => 'Default Game', :quiz_id => quiz.id, :status => 'active' )
    admin = User.create( :email => 'admin@friendfried.com', :password => 'admin' )
    dummy1 = User.create( :email => 'dummy1@friendfried.com', :password => 'dummy' )
    dummy2 = User.create( :email => 'dummy2@friendfried.com', :password => 'dummy' )
    Player.create(:game_id => game.id, :user_id => admin.id, :status => 'active')
    Player.create(:game_id => game.id, :user_id => dummy1.id, :status => 'active')
    Player.create(:game_id => game.id, :user_id => dummy2.id, :status => 'inactive')
    #admin answers
    quiz.questions.each {|q| Answer.create(:game_id => game.id, :question_id => q.id, :player_id => admin.id, :content => "my answer to #{q.content}")}
    #dummy1 answers to odd questions only
    quiz.questions.each {|q| Answer.create(:game_id => game.id, :question_id => q.id, :player_id => dummy1.id, :content => "my answer to #{q.content}") if q.id.odd?}
  end

  desc "Run all bootstrapping tasks"
  task :all => [:default_category, :default_quiz, :default_game]
end