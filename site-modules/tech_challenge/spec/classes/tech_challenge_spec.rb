# frozen_string_literal: true

require 'spec_helper'

describe 'tech_challenge' do
  let(:title) { 'tech_challenge' }
  let(:node) { 'test.example.com' }
  
  context 'RedHat' do
    let(:facts) { {
      :osfamily => 'RedHat',
      :operatingsystem => 'CentOS',
      :operatingsystemmajrelease => 7,
    } }

    it { is_expected.to contain_package(jenkins).with(ensure: 'present') }
    …
    … 
  end

  context 'Debian' do
    let(:facts) { {
    :osfamily => 'Debian',
    :operatingsystem => 'Ubuntu',
    :operatingsystemmajrelease => 20.04,
  } }

    it { is_expected.to contain_package(jenkins).with(ensure: 'present') }
    … 
    … 
  end
end
