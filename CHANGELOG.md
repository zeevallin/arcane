### Arcane **1.2.0** [head][current] - 2015-11-24
* **[breaking change]** If `current_user` is not
  specified `current_params_user` will raise a
  `NameError`.

### Arcane **1.1.1** - 2013-07-17
* **[bugfix]** Handle nil paramaters params as
  @caulfield suggested in pull request #7. Thank you.
  This doesn't break any functionality other than expecting
  nil to return an error on use of nil parameters.

### Arcane **1.1.0** - 2013-07-17
* **[bugfix]** Fixed dependency hell for rails 4.
  Makde sure strong_parameters is optional. Upgrading
  to this will break compatability with rails 3 unless
  you have specifically added `strong_parameters` to
  your Gemfile already.

### Arcane **1.0.0** - 2013-07-13
* **[deprecation]** The `refine` helper no longer
  exist, as it's a proposed keyword for ruby 2.0 look
  to the new features for how to access arcane.

* **[feature]** Introducing chained methods on `params`
  to specify for what, who and how you want arcane to
  refine your parameters. Look in `README.md` for
  detailed information.

* **[feature]** Introducing most rails generators
  to easily create generators for your class in the
  command line. Read Look in `README.md` for
  detailed information.

* **[bugfix]** You can now properly specify
  `refinery_class` in your model.

### Arcane **0.1.1** [old] – 2013-07-11
* **[feature]** The `refine` helper no longer needs a
  refinery method, it will try and detect which one to
  use based on parameters.

### Arcane **0.1.0** [old] – 2013-07-11
* **[bugfix]** Arcane should no longer error when there is
  no current_user present.
* **[feature]** Added new query syntax for the `refine`
  helper. It now supports custom params and/or refinery
  keys to be sent as arguments.

### Arcane **0.0.3** [old] – 2013-07-11
* Initial Release
