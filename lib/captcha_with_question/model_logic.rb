# model mixins
module Soft
  module Props
    module CatchaWithQuestion
      module ModelLogic
        
        def self.included(base)
          base.extend ActMethods 
        end
    
        module ClassMethods 
        end
    
        module InstanceMethods
          def logic_valid?
            unless self.logic_solution.blank?
              errors.add(:logic_solution, Logic.err_msg) unless Logic.find(self.logic).valid_answer?(self.logic_solution)
            end
          end
        end
    
        module ActMethods
          def captchas_with_question(*args)
            unless included_modules.include? InstanceMethods
              extend ClassMethods 
              include InstanceMethods
              options = args.extract_options!.symbolize_keys
              if (includes_typed_key(options,:message,String)) 
                Logic.err_msg = assign_unless_nil options, :message
              end
              if (includes_typed_key(options,:questions,Hash))
                 Logic.replace_logic(options[:questions]) unless options[:questions].nil?
              end
              attr_accessor :logic, :logic_solution
              validates_presence_of :logic_solution, :on => :create, :message => "should not be blank"
              validate_on_create :logic_valid?
            end
          end
      
           private 

            def includes_typed_key(options,symbol,type)
              options.include?(symbol) && options[symbol].is_a?(type)
            end

            def assign_unless_nil(options,symbol)
              options[symbol] unless options[symbol].nil? 
            end
      
        end
      end
    end
  end
end
ActiveRecord::Base.send(:include, Soft::Props::CatchaWithQuestion::ModelLogic)