import React, {Component} from 'react';

class VideoListItem extends Component {
    constructor(props) {
        super(props);
    }

    render() {
        const video = this.props.video;
        const snippet = video.snippet;
        const imageUrl = snippet.thumbnails.default.url;
        const title = snippet.title;
        return (
            <li onClick={this.onVideoSelect.bind(this)} 
                className="list-group=item">
                <div className="video-list-media">
                    <div className="media-left">
                        <img className="media-object" src={imageUrl} />
                    </div>

                    <div className="media-body">
                    <div className="media-heading">{title}</div>
                    </div>
                </div>
            </li>
        );
    }

    onVideoSelect() {
        this.props.onVideoSelect(this.props.video);
    }
}

export default VideoListItem;