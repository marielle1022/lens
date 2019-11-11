import React from 'react';
import RTR from 'react-test-renderer';

import PhotoCard from './card';

test('render photo card', () => {
  const photo  = { data: "about:blank", desc: "no photo" };
  const result = RTR.create(<PhotoCard photo={photo} />);
  expect(result).toMatchSnapshot();
});
