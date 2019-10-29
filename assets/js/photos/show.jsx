import React from 'react';
import ReactDOM from 'react-dom';

import { connect } from 'react-redux';

import { get_photo } from '../ajax';

function state2props(state, props) {
  let id = parseInt(props.id);
  return {id: id, photo: state.photos.get(id)};
}

function PhotosShow({id, photo}) {
  let image = null;

  if (!photo) {
    get_photo(id);

    return (
      <div>
        <h1>Show Photo</h1>
        <p>Loading...</p>
      </div>
    );
  }

  return (
    <div>
      <h1>Show Photo</h1>
      <img src={photo.data} />
      <p>Desc: {photo.desc}</p>
    </div>
  );
}

export default connect(state2props)(PhotosShow);
