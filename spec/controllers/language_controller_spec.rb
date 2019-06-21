require 'rails_helper'

RSpec.describe LanguageController, type: :controller do
  describe "#index" do
    it "responds successfully"

    it "returns a 200 status"
  end

  describe "#show" do
    context "with proper params" do
      it "responds successfully"

      it "returns a 200 status"
    end

    context "with invalid id" do
      it "returns a 404 status"
    end
  end

  describe "#create" do
    context "with proper params" do
      it "returns a 200 status"

      it "add a word"
    end

    context "with invalid params" do
      it "does not add a word"

      it "returns a 200 status"
    end
  end

  describe "#update" do
    context "with proper params" do
      it "returns a 200 status"

      it "change a word"
    end

    context "with invalid id" do
      it "returns a 404 status"

      it "does not change a word"
    end
  end

  describe "#destory" do
    context "with proper params" do
      it "returns a 200 status"

      it "delete a word"
    end

    context "with invalid id" do
      it "returns 404 status"

      it "does not delete a word"
    end
  end

end
