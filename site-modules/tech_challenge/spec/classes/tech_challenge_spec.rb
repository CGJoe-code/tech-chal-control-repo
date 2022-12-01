# frozen_string_literal: true

require 'spec_helper'

describe 'tech_challenge' do
  let(:title) { 'tech_challenge' }
  let(:node) { 'test.example.com' }
  
  context 'Centos' do
    let(:facts) { {
      :operatingsystem => 'CentOS',
      :operatingsystemmajrelease => 7,
    } }

    it { is_expected.to contain_package(jenkins).with(ensure: 'present') }
    …
    … 
  end

  context 'Ubuntu' do
    let(:facts) { {
    :operatingsystem => 'Ubuntu',
    :operatingsystemmajrelease => 20.04,
  } }

    it { is_expected.to contain_package(jenkins).with(ensure: 'present') }
    … 
    … 
  end
end
