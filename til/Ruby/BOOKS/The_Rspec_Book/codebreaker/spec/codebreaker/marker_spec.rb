require 'spec_helper'

module Codebreaker
  describe Marker do

    describe "#total_match" do 
        it "returns 1 with duplicate" do
          marker = Marker.new('1234','1111')
          expect(marker.total_match_count).to eq 1
        end
        it "returns 2 with duplicate" do
          marker = Marker.new('1234','1133')
          expect(marker.total_match_count).to eq 2
        end
        it "returns 2 with duplicate" do
          marker = Marker.new('1134','1155')
          expect(marker.total_match_count).to eq 2
        end
    end

    describe "#exact_match_count" do
      context "with no matches" do
        it "returns 0" do
          marker = Marker.new('1234','5555')
          expect(marker.exact_match_count).to eq 0
        end
      end
      context "with 1 match" do
        it "returns 1" do
          marker = Marker.new('1234','1555')
          expect(marker.exact_match_count).to eq 1
        end
      end
      context "with 2 match" do
        it "returns 2" do
          marker = Marker.new('1134','1155')
          expect(marker.exact_match_count).to eq 2
        end
      end
      context "with 2 match" do
        it "returns 2" do
          marker = Marker.new('1234','1354')
          expect(marker.exact_match_count).to eq 2
        end
      end
      context "with 1 number match and 1 exact match (in that order)" do
        it "returns 1" do
          marker = Marker.new('1234','1525')
          expect(marker.number_match_count).to eq 1
        end
      end
    end

    describe "#number_match_count" do
      context "with no matches" do
        it "returns 0" do
          marker = Marker.new('1134','1155')
          expect(marker.number_match_count).to eq 0
        end
      end
      context "with no matches" do
        it "returns 0" do
          marker = Marker.new('1234','1111')
          expect(marker.number_match_count).to eq 0
        end
      end
      context "with no matches" do
        it "returns 0" do
          marker = Marker.new('1234','5555')
          expect(marker.number_match_count).to eq 0
        end
      end
      context "with 1 match" do
        it "returns 1" do
          marker = Marker.new('1234','2555')
          expect(marker.number_match_count).to eq 1
        end
      end
      context "with 2 matches" do
        it "returns 2" do
          marker = Marker.new('1234','2355')
          expect(marker.number_match_count).to eq 2
        end
      end
      context "with 1 number match and 1 exact match (in that order)" do
        it "returns 1" do
          marker = Marker.new('1234','1525')
          expect(marker.number_match_count).to eq 1
        end
      end
      context "with 1 exact match duplicated in guess" do 
        it "return 0" do
          marker = Marker.new('1234','1155')
          expect(marker.number_match_count).to eq 0
        end
      end
    end

  end
end
