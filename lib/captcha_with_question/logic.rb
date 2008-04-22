# model for question and answer
class Logic
  attr_reader :question, :answer  
  DEFAULT_QUESTIONS = { 'How do you spell blue?'=>'blue',
                'How do you spell red?'=>'red',
                'How do you spell green?'=>'green' }
           
  @@err_message = 'looks a bit off.'
  
  def initialize(question=nil,answer=nil)
    @question = question || DEFAULT_QUESTIONS.sort_by{rand}.first[0]
    @answer = answer || DEFAULT_QUESTIONS[@question]
  end
  
  def valid_answer?(answer) 
    valid = false
    unless answer.nil?
      case answer.type
        when String
           valid=answer.downcase == solution
        default 
          valid=answer.downcase == solution
      end
    else
      valid=false
    end
    valid
  end
  
  def to_s() "#{@question}" end
    
  def self.merge_logic(logic) DEFAULT_QUESTIONS.merge!(logic) unless logic.nil? end
  
  def self.replace_logic(logic) 
    DEFAULT_QUESTIONS.clear
    DEFAULT_QUESTIONS.merge!(logic) unless logic.nil? 
  end
  
  
  def self.err_msg=(msg=@@err_message) @@err_message=msg end
  
  def self.err_msg() @@err_message end
  
  # finds a given bit of logic based on a question
  def self.find(question) self.new(question,DEFAULT_QUESTIONS[question]) end
  
  private
  # defines what a solution is
  # note: currently only handles strings
  def solution() 
    case @answer.type
      when String
        solution= @answer.downcase 
      default 
        solution= @answer
    end
    solution
  end
end