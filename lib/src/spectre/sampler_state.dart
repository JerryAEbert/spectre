part of spectre;

/*

  Copyright (C) 2012 John McCutchan <john@johnmccutchan.com>

  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.

*/

/// Contains sampler state, which determines how to sample texture data.
class SamplerState extends DeviceChild {
  //---------------------------------------------------------------------
  // Serialization names
  //---------------------------------------------------------------------

  /// Serialization name for [addressU].
  static const String _addressUName = 'addressU';
  /// Serialization name for [wrapV].
  static const String _addressVName = 'addressV';
  /// Serialization name for [maxAnisotropy].
  static const String _maxAnisotropyName = 'maxAnisotropy';

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The texture-address mode for the u-coordinate.
  int _addressU = TextureAddressMode.Clamp;
  /// The texture-address mode for the v-coordinate.
  int _addressV = TextureAddressMode.Clamp;
  /// The maximum anisotropy.
  ///
  /// The default value is 1.
  int _maxAnisotropy = 1;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of [SamplerState] with default values.
  SamplerState(String name, GraphicsDevice device)
    : super._internal(name, device);


  static const int TextureMagFilterLinear = WebGLRenderingContext.LINEAR;
  static const int TextureMagFilterNearest = WebGLRenderingContext.NEAREST;

  static const int TextureMinFilterLinear = WebGLRenderingContext.LINEAR;
  static const int TextureMinFilterNearest = WebGLRenderingContext.NEAREST;
  static const int TextureMinFilterNearestMipmapNearest = WebGLRenderingContext.NEAREST_MIPMAP_NEAREST;
  static const int TextureMinFilterNearestMipmapLinear = WebGLRenderingContext.NEAREST_MIPMAP_LINEAR;
  static const int TextureMinFilterLinearMipmapNearest = WebGLRenderingContext.LINEAR_MIPMAP_NEAREST;
  static const int TextureMinFilterLinearMipmapLinear = WebGLRenderingContext.LINEAR_MIPMAP_LINEAR;

  int magFilter = TextureMagFilterLinear;
  int minFilter = TextureMinFilterNearestMipmapLinear;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The texture-address mode for the u-coordinate.
  int get addressU => _addressU;
  set addressU(int value) {
    if (!TextureAddressMode.isValid(value)) {
      throw new ArgumentError('addressU must be an enumeration within TextureAddressMode.');
    }

    _addressU = value;
  }

  /// The texture-address mode for the v-coordinate.
  int get addressV => _addressV;
  set addressV(int value) {
    if (!TextureAddressMode.isValid(value)) {
      throw new ArgumentError('addressU must be an enumeration within TextureAddressMode.');
    }

    _addressU = value;
  }

  /// The maximum anisotropy.
  ///
  /// Anisotropic filtering is only available through an extension to WebGL.
  /// The maximum acceptable value is dependent on the graphics hardware, and
  /// can be queried within [GraphicsDeviceCapabilites].
  ///
  /// Throws [ArgumentError] if [value] is not a positive number.
  int get maxAnisotropy => _maxAnisotropy;
  set maxAnisotropy(int value) {
    if (value < 0) {
      throw new ArgumentError('maxAnisotropy must be a positive number');
    }

    _maxAnisotropy = value;
  }

  //---------------------------------------------------------------------
  // Serialization
  //---------------------------------------------------------------------

  /// Serializes the [SamplerState] to a JSON.
  dynamic toJson() {
    Map json = new Map();

    json[_addressUName] = TextureAddressMode.stringify(_addressU);
    json[_addressVName] = TextureAddressMode.stringify(_addressV);

    json[_maxAnisotropyName] = _maxAnisotropy;

    return json;
  }

  /// Deserializes the [SamplerState] from a JSON.
  void fromJson(Map values) {
    assert(values != null);

    dynamic value;

    value = values[_addressUName];
    _addressU = (value != null) ? TextureAddressMode.parse(value) : _addressU;

    value = values[_addressVName];
    _addressV = (value != null) ? TextureAddressMode.parse(value) : _addressV;

    value = values[_maxAnisotropyName];
    _maxAnisotropy = (value != null) ? value : _maxAnisotropy;
  }
}
