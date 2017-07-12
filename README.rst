======================
napalm-install-formula
======================

Although the installation of NAPALM is very easy, some underlying Python libraries have certain dependencies on various operating systems.
This SaltStack formula provides the necessary state to install the required packages.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.


Available states
================

.. contents::
    :local:

``napalm_install``
------------------

Install the NAPALM libraries and their system requirements.

Example Pillar
==============

.. code:: yaml

    napalm:
      install:
        - napalm-junos
        - napalm-ios
        - napalm-iosxr

See *pillar.example*.

Usage
=====

.. note::

    As NAPALM is mostly used when working with proxy minions,
    it is good to keep in mind this distinction: proxy minions
    manage the network gear, while regular minion(s) manage the
    server(s) where the proxy minions run.
    Hence, this formula is designed to be executed on the
    regular minion, in order to prepare the environment for the proxies.

From the minion server:

.. code-block:: bash

  $ sudo salt-call state.sls napalm_install

From the master, targeting the server(s) where we need to install NAPALM:

.. code-block:: bash

  $ sudo salt 'server-for-napalm' state.sls napalm_install

Usage Example
=============

.. code-block:: bash

    $ sudo salt-call state.sls napalm_install
    local:
    ----------
              ID: install_napalm_junos_pkgs
        Function: pkg.installed
          Result: True
         Comment: 5 targeted packages were installed/updated.
                  The following packages were already installed: python-pip, libxml2-dev
         Started: 11:47:43.398503
        Duration: 6123.864 ms
         Changes:
                  ----------
                  libffi-dev:
                      ----------
                      new:
                          3.1-2+deb8u1
                      old:
                  libffi6:
                      ----------
                      new:
                          3.1-2+deb8u1
                      old:
                          3.1-2+b2
                  libssl-dev:
                      ----------
                      new:
                          1.0.1t-1+deb8u6
                      old:
                  libxslt-dev:
                      ----------
                      new:
                          1
                      old:
                  libxslt1-dev:
                      ----------
                      new:
                          1.1.28-2+deb8u3
                      old:
                  python-cffi:
                      ----------
                      new:
                          0.8.6-1
                      old:
                  python-dev:
                      ----------
                      new:
                          2.7.9-1
                      old:
                  python-dev:any:
                      ----------
                      new:
                          1
                      old:
    ----------
              ID: napalm-junos
        Function: pip.installed
          Result: True
         Comment: All packages were successfully installed
         Started: 11:47:50.485667
        Duration: 2536.705 ms
         Changes:
                  ----------
                  napalm-junos==0.11.0:
                      Installed
    ----------
              ID: install_napalm_iosxr_pkgs
        Function: pkg.installed
          Result: True
         Comment: All specified packages are already installed
         Started: 11:47:53.023603
        Duration: 4.962 ms
         Changes:
    ----------
              ID: napalm-iosxr
        Function: pip.installed
          Result: True
         Comment: All packages were successfully installed
         Started: 11:47:53.028663
        Duration: 4820.892 ms
         Changes:
                  ----------
                  napalm-iosxr==0.5.1:
                      Installed

    Summary for local
    ------------
    Succeeded: 4 (changed=2)
    Failed:    0
    ------------
    Total states run:     4
    Total run time:  13.486 s
