
var Comment = React.createClass({
  render: function(){
    return (
      <div class="comment">
        <p class="commentBody"> <i>
          {this.props.text}
        </i></p>
        <h4 class="commentAuthor">
          {this.props.author}
        </h4>
      </div>
    );
  }
});

var CommentsBox = React.createClass({

  loadCommentsFromServer: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      cache: false,
      success: function(data) {
        this.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  getInitialState: function(){
    return {data: []};
  },

  componentDidMount: function(){
    this.loadCommentsFromServer();
    setInterval(this.loadCommentsFromServer, 2000);
  },

  render: function() {
    return (
      <div class="commentBox">
        <h2> Comments </h2>
        <h3> Url is: {this.props.url} </h3>
        <CommentList data={this.state.data} />
      </div>
    );
  }
});

var CommentList = React.createClass({
  render: function(){
    var commentNodes = this.props.data.map(function(comment){
      return (
        <Comment author={comment.commenter} key={comment.id}>
          {comment.body}
        </Comment>
      );
    });
    return (
      <div class="commentList">
        {commentNodes}
      </div>
    );
  }
});

ReactDOM.render(
  <CommentBox url={"/api/articles/"+this.props.article_id+"/comments"} />,
  document.getElementById('content')
);
