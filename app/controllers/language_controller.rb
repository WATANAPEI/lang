class LanguageController < ApplicationController
  def index
    languages = Language.all
    render json: {status: "SUCCESS", message: "loaded languages", data: languages }
  end

  def show
    language = Language.find(params[:id])
    render json: {status: "SUCCESS", message: "loaded the language", data: language }
  end

  def create
    language = Language.new(language_params)
    if language.save
      render json: {status: "SUCCESS", message: "the language saved.", data: language}
    else
      render json: {status: "SUCCESS", message: "the language does not saved.", data: language.errors}
    end
  end

  def update
    language = Language.find(params[:id])
    if language.update(language_params)
      render json: { status: 'SUCCESS', message: 'the language is updated', data: language }
    else
      render json: {status: 'ERROR', message: 'the language is not updated', data: language.errors}
    end
  end

  def destroy
    language = Language.find(params[:id])
    language.destroy
    render json: { status: 'SUCCESS', message: 'the language is deleted', data: language }
  end
end
