var CommentsBox = React.createClass({
  propTypes: {
    body: React.PropTypes.string,
    author: React.PropTypes.string
  },

  render: function() {
    return (
      <div>
        <div>Body: {this.props.body}</div>
        <div>Author: {this.props.author}</div>
      </div>
    );
  }
});
