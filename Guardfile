group 'mot' do
    guard 'motion' do
      watch(%r{^spec/.+_spec\.rb$})
      watch(%r{^app/(.+)\.rb$})     { |m| "./spec/#{m[1]}_spec.rb" }
    end
end

group 'cuke' do
    guard 'cucumber' do
      watch(%r{^features/.+\.feature$})
      watch(%r{^features/support/.+$})          { 'features' }
      watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
    end
end
