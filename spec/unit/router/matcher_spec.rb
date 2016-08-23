require 'spec_helper'

describe RapidRunty::Router::Matcher do
  let!(:matcher) { described_class.new }

  describe 'match paths' do
    let(:routes) do
      [
        { url: '/foo', to: 'foo#index' },
        { url: '/foo/:id', to: 'foo#show' },
        { url: '/', to: 'root#home' }
      ]
    end

    it 'return the matched route' do
      expect(matcher.match('/foo', routes)).
        to be_eql(
          ['/foo', {}, { 'controller' => 'foo', 'action' => 'index' }]
      )

      expect(matcher.match('/foo/4', routes)).
        to be_eql(
          [
            '/foo/:id',
            {'id' => '4'},
            { 'controller' => 'foo', 'action' => 'show' }
          ]
      )

      expect(matcher.match('/', routes)).
        to be_eql ['/', {}, { 'controller' => 'root', 'action' => 'home' }]
    end

    it 'return empty results of no match' do
      expect(matcher.match('/bar', routes)).to be_eql [nil, {}, {}]
    end
  end

  describe 'patterns' do
    let(:path) { RapidRunty::Router::RouteParser.new('/foo/bar') }
    let(:pattern) { RapidRunty::Router::RouteParser.new('/:foo/:bar') }

    it 'matches all placeholders' do
      expect(pattern.==(path)).to be_truthy
      expect(pattern.placeholders).to be_eql({ 'foo' => 'foo', 'bar' => 'bar' })
    end
  end
end
