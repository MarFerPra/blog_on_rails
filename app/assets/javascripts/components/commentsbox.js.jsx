
var Comment = React.createClass({
  render: function(){
    return (
      <div className="Comment">
        <p> <i>
          {this.props.text}
        </i></p>
        <h4>
          {this.props.author}
        </h4>
      </div>
    );
  }
});

var CommentsBox = React.createClass({
  getInitialState: function(){
    return {
      data: [],
      url: "/api/articles/"+this.props.article_id+"/comments"
    };
  },

  loadCommentsFromServer: function() {
    console.log(this.state.url);
    $.ajax({
      url: this.state.url,
      dataType: 'json',
      type: 'GET',
      cache: false,
      success: function(data) {
        this.setState({data: data.comments});
      }.bind(this),
      error: function(xhr, status, err){
        console.error(this.state.url, status, err.toString());
      }.bind(this)
    });
  },

  componentDidMount: function(){
    this.loadCommentsFromServer();
    setInterval(this.loadCommentsFromServer, this.props.pollInterval);
  },

  render: function() {
    return (
      <div className="CommentsBox">
        <h2> Comments </h2>
        <h3> Url is: {this.state.url} </h3>
        <CommentList data={this.state.data} />
      </div>
    );
  }
});

var CommentList = React.createClass({
  render: function(){
    var commentNodes = this.props.data.map(function(comment){
      return (
        <Comment author={comment.commenter} key={comment.id} text={comment.body} />
      );
    });
    return (
      <div className="CommentList">
        {commentNodes}
      </div>
    );
  }
});
