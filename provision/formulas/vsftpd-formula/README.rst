vsftpd
=======
Install and configure a vsftpd server.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``vsftpd``
-----------

Installs the ``vsftpd`` server package and service.

``vsftpd.config``
------------------

Installs the vsftpd daemon configuration file included in this formula
(under "vsftpd/files"). This configuration file is populated
by values from pillar. ``pillar.example`` results in the generation
of the default ``vsftpd.conf`` file on Ubuntu 14.04 Trusty Tahr .