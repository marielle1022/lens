
import store from './store';

export function post(path, body) {
   return fetch('/ajax' + path, {
    method: 'post',
    credentials: 'same-origin',
    headers: new Headers({
      'x-csrf-token': window.csrf_token,
      'content-type': "application/json; charset=UTF-8",
      'accept': 'application/json',
    }),
    body: JSON.stringify(body),
  }).then((resp) => resp.json());
}

export function get(path) {
  return fetch('/ajax' + path, {
    method: 'get',
    credentials: 'same-origin',
    headers: new Headers({
      'x-csrf-token': window.csrf_token,
      'content-type': "application/json; charset=UTF-8",
      'accept': 'application/json',
    }),
  }).then((resp) => resp.json());
}

export function get_photo(id) {
  get('/photos/'+id)
    .then((resp) => {
        store.dispatch({
          type: 'ADD_PHOTOS',
          data: [resp.data],
        });
    });
}

export function list_photos() {
   get('/photos')
    .then((resp) => {
      console.log("list_photos", resp);
      store.dispatch({
        type: 'ADD_PHOTOS',
        data: resp.data,
      });
    });
}

export function submit_new_photo(form) {
  let state = store.getState();
  console.log("state", state);
  let data = state.forms.new_photo;

  if (data.file == null) {
    return;
  }

  let reader = new FileReader();
  reader.addEventListener("load", () => {
    post('/photos', {
      photo: {
        desc: data.desc,
        filename: data.file.name,
        data: reader.result,
        user_id: 1,
      }
    }).then((resp) => {
      console.log(resp);
      if (resp.data) {
        store.dispatch({
          type: 'ADD_PHOTOS',
          data: [resp.data],
        });
        form.redirect('/photos/' + resp.data.id);
      }
      else {
        store.dispatch({
          type: 'CHANGE_NEW_PHOTO',
          data: {errors: JSON.stringify(resp.errors)},
        });
      }
    });
  });

  reader.readAsDataURL(data.file);
}
