import React, {Component} from 'react';
import VideoListItem from './video_list_item';

class VideoList extends Component {
    render() {
        const videoItems = this.props.videos.map((video) => {
            return (
                <VideoListItem 
                onVideoSelect={this.props.onVideoSelect}
                key={video.etag} 
                video={video} />
            );
        });

        return (
            <div>
                <ul className="col-md-4 list-group">
                    {videoItems}
                </ul>
            </div>
        );
    }
}

export default VideoList;