var CommentBox = React.createClass({

  getInitialState: function(){
    return {data:[]};
  },

  loadCommentsFromServer: function(){
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      cache: false,
      success: function(data){
        this.setState({data: data });
      }.bind(this),
      error: function(xhr, status, err){
        console.error(this.props.url,status,err.toString());
      }.bind(this)
    });
  },

  handleCommentSubmit: function(comment){
    // Añadir el comentario antes de recibir la respuesta para dar más
    // fluidez a la interfaz, en caso de que haya un error se elimina y
    // vuelve al estado anterior.
    var comments = this.state.data;
    comment.id = Date.now(); // Id temporal que se sustituye luego, en
    // produccion conviene usar algo más robusto que Date.now()
    var newComments = coments.concat([comment]);
    this.setState({data: newComments});
    // submit to the server and refresh the list.
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      type: 'POST',
      data: comment,
      success: function(data){
        this.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err){
        this.setState({data:comments});
        console.error(this.props.url,status,err.toString());
      }.bind(this)
    });
  },

  componentDidMount: function(){
    this.loadCommentsFromServer();
    setInterval(this.loadCommentsFromServer, this.props.pollInterval);
  },

  render: function() {
    return (
      <div className ="commentBox">
      <h1> Comments </h1>
      <CommentList data = {this.state.data} />
      <CommentForm  onCommentSubmit={this.handleCommentSubmit} />
      </div>
    );
  }
});

React.DOM.render(
  <CommentBox url="/api/comments" pollInterval={2000} />,
  document.getElementById('content')
);
