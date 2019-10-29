import React from 'react';
import ReactDOM from 'react-dom';

import { connect } from 'react-redux';
import _ from 'lodash';

import { list_photos } from '../ajax';
import PhotoCard from './card';

let PhotosList = connect(({photos}) => ({photos}))(({photos}) => {
  if (photos.size == 0) {
    list_photos();
  }

  let cards = _.map([...photos], ([_, photo]) => {
    return <PhotoCard key={photo.id} photo={photo} />;
  });

  return (
    <div>
      <h1>Photos</h1>
      <div className="row">
        {cards}
      </div>
    </div>
  );
});

export default PhotosList;
