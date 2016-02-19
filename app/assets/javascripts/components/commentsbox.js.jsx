
var Comment = React.createClass({
  render: function(){
    return (
      <div className="Comment">
        <p><i>
          {this.props.text}
        </i></p>
        <p>
          - {this.props.author}
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
        <CommentForm current_user={this.props.current_user} />
      </div>
    );
  }
});

var CommentForm = React.createClass({
  getInitialState: function(){
    return {author:'', text:''};
  },
  handleAuthorChange: function(e){
    this.setState({author: e.target.value});
  },
  handleTextChange: function(e){
    this.setState({text: e.target.value});
  },
  handleSubmit: function(e){
    e.preventDefault();
    var author = this.state.author.trim();
    var text = this.state.text.trim();
    if(!text  || !author){
      return;
    }
    this.props.onCommentSubmit({author: author, text: text});
    this.setState({author:'', text:''});
  },
  render: function(){
    return(
      <form className="commentForm" onSubmit={this.handleSubmit}>
        <p>
          <input
            type="text"
            placeholder="Your name"
            class="form-control commenter_name"
            value={this.state.author}
            onChange={this.handleAuthorChange}
          />
        </p>
        <p>
          <input
            type="text"
            placeholder="Whatever you have to say"
            class="form-control comment_text"
            value={this.state.text}
            onChange={this.handleTextChange}
          />
        </p>
        <p>
          <input type="submit" value="Post comment"
            class="btn btn-info btn-default btn-block"/>
        </p>
      </form>
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
    return(
      <div className="CommentList">
        {commentNodes}
      </div>
    );
  }
});
