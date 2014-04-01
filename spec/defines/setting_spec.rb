require 'spec_helper'

describe 'bios::setting' do

  let(:title) { 'test_setting' }
  let(:params) {{
    'value' => "test_value"
  }}
  let(:facts) {{
    'boardmanufacturer' => 'Intel',
    'boardproductname'  => 'S2600GZ', 
  }}

  it { should compile }

end
