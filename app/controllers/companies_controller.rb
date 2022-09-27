class CompaniesController < ApplicationController

def index
  if params[:query].present?
    @company = Company.search_by_everything(params[:query])
  end
end

private

def company_params
  params.require(:company).permit(:name)
end

def set_companies
  @company = Company.find(params[:id])
end
end
