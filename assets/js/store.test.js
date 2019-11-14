import { createStore } from 'redux';

import { _store, root_reducer } from './store';

test('create and update store', () => {
  let store = createStore(root_reducer);
  expect(localStorage.getItem).toHaveBeenCalledWith("session");

  let st0 = store.getState();
  expect(st0.session).toBeNull();
  expect(st0.photos.size).toBe(0);

  store.dispatch({
    type: 'ADD_PHOTOS',
    data: [{data: "about:blank", desc: "demo"}],
  });

  let st1 = store.getState();
  expect(st1.photos.size).toBe(1);
});
