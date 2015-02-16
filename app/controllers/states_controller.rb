class StatesController < ApplicationController


  def set_state
    klass = params[:klass]
    project = Project.find_by_identifier(params[:project_id])
    if params[:wiki_page] == "root"
      wiki_content = WikiPage.find_by_title(project.wiki.start_page).content
    else
      wiki_content = WikiPage.find_by_title(params[:wiki_page]).content
    end

    doc = Nokogiri::HTML::DocumentFragment.parse(wiki_content.text)
    nodeset = doc.css("input.#{klass}").first
    if params[:state] == "checked"
      nodeset.attributes["checked"].remove
    else
      nodeset["checked"] = "checked"
    end

    wiki_content.text = doc.to_html
    if wiki_content.save
    respond_to do |format|
      format.js {render js: true}
    end
    else
      respond_to do |format|
        format.js {render js: "Error"}
      end
    end


  end


end