editor = new wysihtml5.Editor("wysihtml5-textarea", # id of textarea element
  toolbar: "wysihtml5-toolbar" # id of toolbar element
  stylesheets: "<%= stylesheet_path('wysiwyg') %>" # optional, css to style the editor's content
  parserRules: wysihtml5ParserRules # defined in parser rules set
)  
