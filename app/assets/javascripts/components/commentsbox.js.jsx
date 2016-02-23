
var Comment = React.createClass({
  render: function(){
    return (
      <div className="Comment">
        <p><i>
          {this.props.text}
        </i></p>
        <p>
            - {this.props.author} ({this.props.created_at})
        </p>
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
        <h5><strong> Comments: </strong></h5>
        <CommentList data={this.state.data} />
      </div>
    );
  }
});

var CommentList = React.createClass({
  render: function(){
    var commentNodes = this.props.data.map(function(comment){
      return (
        <Comment author={comment.commenter} key={comment.id} text={comment.body} created_at={comment.created_at} />
      );
    });
    return(
      <div className="CommentList">
        {commentNodes}
      </div>
    );
  }
});
